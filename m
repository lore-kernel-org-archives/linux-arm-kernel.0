From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jun 2015 16:11:06 +0100
Subject: [PATCH v5 05/17] input: make LoCoMo keyboard driver support both
 poodle and collie
In-Reply-To: <1433797008-6246-6-git-send-email-dbaryshkov@gmail.com>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-6-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150614151106.GD7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 11:56:36PM +0300, Dmitry Eremin-Solenikov wrote:
> @@ -278,6 +281,11 @@ static int locomokbd_probe(struct platform_device *dev)
>  			locomokbd_keycode,
>  			sizeof(locomokbd->keycode));
>  
> +	if (machine_is_collie())
> +		locomokbd->keycode[18] = KEY_HOME;
> +	else
> +		locomokbd->keycode[3] = KEY_HOME;

We had decided that we weren't allowing any new machine_is_xxx() in drivers.
Why can't this difference be encoded via platform data, so it can be later
encoded in DT if sa11x0 moves in that direction?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
