From: afleming@gmail.com (Andy Fleming)
Date: Wed, 23 Mar 2011 19:24:04 -0500
Subject: [RFC PATCH] et1011c: Replaced PHY driver by a small dm646x board
	fixup
In-Reply-To: <1300919616-6780-1-git-send-email-Kyle.D.Moffett@boeing.com>
References: <091F7EC1-5D33-4C90-AFC1-D6E24EF3EEC6@boeing.com>
	<1300919616-6780-1-git-send-email-Kyle.D.Moffett@boeing.com>
Message-ID: <AANLkTin14WSZsc7+B-rK1dSn=XShNrF63k_47RXu-3G6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 5:33 PM, Kyle Moffett <Kyle.D.Moffett@boeing.com> wrote:

> -
> -static struct phy_driver et1011c_driver = {
> - ? ? ? .phy_id ? ? ? ? = 0x0282f014,
> - ? ? ? .name ? ? ? ? ? = "ET1011C",
> - ? ? ? .phy_id_mask ? ?= 0xfffffff0,
> - ? ? ? .features ? ? ? = (PHY_BASIC_FEATURES | SUPPORTED_1000baseT_Full),
> - ? ? ? .flags ? ? ? ? ?= PHY_POLL,
> - ? ? ? .config_aneg ? ?= et1011c_config_aneg,
> - ? ? ? .read_status ? ?= et1011c_read_status,
> - ? ? ? .driver ? ? ? ? = { .owner = THIS_MODULE,},
> -};


Might I suggest that you not eliminate the whole driver?  If you leave
just this part (and the init stuff below it), and convert the
config_aneg and read_status pointers to use the genphy versions, the
kernel will, at least, be able to report what type of PHY it is.  And
maybe one day, someone who is familiar with the inner workings of this
PHY will fill in a more correct driver.

Andy
