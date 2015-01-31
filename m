From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jan 2015 11:39:52 +0000
Subject: [PATCH v2 10/12] ASoC: dw-hdmi-audio: add codec driver for dw
 hdmi audio
In-Reply-To: <1422618071-27178-1-git-send-email-ykk@rock-chips.com>
References: <1422617031-25098-1-git-send-email-ykk@rock-chips.com>
 <1422618071-27178-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20150131113952.GB26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 06:41:11AM -0500, Yakir Yang wrote:
> codec driver creat an standard alsa device, than config audio
> and report jack status through some callback interfaces that
> dw_hdmi driver support.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v2:
> - Update dw_hdmi audio control interfaces, and adjust jack report process

As you are aware, this can't work with iMX6 SoCs.  We need to come up with
some way to deal with the different IP cores in a sane way.

The "codec" part of this IP is different between the two implementations;
your ASoC codec driver is not useful on the iMX6 SoC implementation.

We need to find a way to allow these two implementations to co-exist
sanely.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
