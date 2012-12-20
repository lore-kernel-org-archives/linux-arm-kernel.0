From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Dec 2012 08:40:41 -0200
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <CAOMZO5B1DyktHa0Vfb4+-H9bdxaoacas6ZCHEH0bDLuKiCB6hA@mail.gmail.com>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
 <20121218024353.GA17118@kroah.com>
 <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
 <20121220043943.GA992@nchen-desktop>
 <CAOMZO5B1DyktHa0Vfb4+-H9bdxaoacas6ZCHEH0bDLuKiCB6hA@mail.gmail.com>
Message-ID: <CAOMZO5DtiknWX7io6bgVew=gS5BX+yka1F=AizF7sjaK06rjXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 8:20 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Excellent! Your suggestion made scp work with mx6 on 3.7.
>
> I assume that this "fix" or workaround would need a better place, right?
>
> Should this fix go into the chipidea host driver instead?

Also, we are already passing the CI13XXX_DISABLE_STREAMING flag:

static struct ci13xxx_platform_data ci13xxx_imx_platdata  = {
	.name			= "ci13xxx_imx",
	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
				  CI13XXX_PULLUP_ON_VBUS |
				  CI13XXX_DISABLE_STREAMING,
	.capoffset		= DEF_CAPOFFSET,
};

Regards,

Fabio Estevam
