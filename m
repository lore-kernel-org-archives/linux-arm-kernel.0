From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jan 2015 12:08:14 +0000
Subject: [RFC 02/11] i2c: add quirk checks to core
In-Reply-To: <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
Message-ID: <20150112120814.GE12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 06:21:32PM +0100, Wolfram Sang wrote:
> +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
> +{
> +	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
> +	return -EOPNOTSUPP;
> +}

So, what happens if I open an I2C adapter, find a message which causes
i2c_quirk_error() to be called, and then spin repeatedly calling that...
Shouldn't there be some rate limiting to this?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
