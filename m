From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 1 Oct 2013 13:45:04 +0530
Subject: [PATCH 2/3] Phy: Exynos: Add Exynos5250 sata phy driver
In-Reply-To: <1380609183-21430-3-git-send-email-yuvaraj.cd@samsung.com>
References: <1380609183-21430-1-git-send-email-yuvaraj.cd@samsung.com>
 <1380609183-21430-3-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <CAK9yfHzpiU+ugak6escnn2ioAq8yvTjK7RzrQaUrL7cwwq_EMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yuvaraj,

On 1 October 2013 12:03, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:

> +static int exynos_sata_i2c_remove(struct i2c_client *client)
> +{
> +       dev_info(&client->adapter->dev,
> +               "detached %s from i2c adapter successfully\n",
> +               client->name);
> +
> +       return 0;
> +}
> +

Since this function does not do anything, this could be removed.

> +static const struct i2c_device_id phy_i2c_device_match[] = {
> +       { "sata-phy-i2c", 0 },
> +};
> +MODULE_DEVICE_TABLE(of, phy_i2c_device_match);
> +
> +struct i2c_driver sataphy_i2c_driver = {
> +       .probe    = exynos_sata_i2c_probe,
> +       .id_table = phy_i2c_device_match,
> +       .remove         = exynos_sata_i2c_remove,
> +       .driver   = {
> +               .name = "sata-phy-i2c",
> +               .owner = THIS_MODULE,
> +               .of_match_table = (void *)phy_i2c_device_match,

type casting is not required.

-- 
With warm regards,
Sachin
