From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Apr 2014 02:42:54 +0200
Subject: [PATCH 01/15] pinctrl: sunxi: Add const qualifier to the pin
 descriptor
In-Reply-To: <1398711701-11309-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398711701-11309-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140429024254.772577a9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Mon, 28 Apr 2014 12:01:27 -0700, Maxime Ripard wrote:

> -	pctl->desc = (struct sunxi_pinctrl_desc *)device->data;
> +	pctl->desc = (const struct sunxi_pinctrl_desc *)device->data;

I believe you no longer need the cast here. You used to need a cast
because you were putting a 'const void *' pointer into a non-const
pointer. Now that pctl->desc is const, the cast has become useless, I
believe.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
