From: timur@tabi.org (Timur Tabi)
Date: Sun, 27 Oct 2013 22:41:56 -0500
Subject: [alsa-devel] [PATCH v2 2/6] ASoC: sirf: add I2S CPU DAI driver
In-Reply-To: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
References: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <CAOZdJXUW5u5Zh561-FHGHfW-fK20L_EeBcdBtSeanWqTfkmndQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 5:37 PM, Barry Song <21cnbao@gmail.com> wrote:
> +       si2s->sirf_pcm_pdev = platform_device_register_simple("sirf-pcm-audio",
> +                       0, NULL, 0);
> +       if (IS_ERR(si2s->sirf_pcm_pdev))
> +               return PTR_ERR(si2s->sirf_pcm_pdev);
> +
> +       platform_set_drvdata(pdev, si2s);
> +
> +       spin_lock_init(&si2s->lock);
> +
> +       ret = of_property_read_u32(pdev->dev.of_node,
> +                       "sirf,i2s-dma-rx-channel", &rx_dma_ch);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Unable to USP0 rx dma channel\n");
> +               return ret;
> +       }

Shouldn't you also call platform_device_unregister() before the 'return' here?
