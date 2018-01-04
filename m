From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Jan 2018 18:13:29 +0530
Subject: [PATCH v4 5/7] clk: Introduce davinci clocks
In-Reply-To: <1514763588-31560-6-git-send-email-david@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-6-git-send-email-david@lechnology.com>
Message-ID: <d0165dc8-c23c-c939-d1b7-f10be3b10553@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Monday 01 January 2018 05:09 AM, David Lechner wrote:
> +	/* TODO: old davinci clocks for da850 set MDCTL_FORCE bit for sata and
> +	 * dsp here. Is this really needed?
> +	 */

The commit that introduced this flag suggests so.

commit aad70de20fc69970a3080e7e8f02b54a4a3fe3e6
Author:     Sekhar Nori <nsekhar@ti.com>
AuthorDate: Wed Jul 6 06:01:22 2011 +0000
Commit:     Sekhar Nori <nsekhar@ti.com>
CommitDate: Fri Jul 8 11:10:09 2011 +0530

    davinci: enable forced transitions on PSC

    Some DaVinci modules like the SATA on DA850
    need forced module state transitions.

    Define a "force" flag which can be passed to
    the PSC config function to enable it to make
    forced transitions.

    Forced transitions shouldn't normally be attempted,
    unless the TRM explicitly specifies its usage.

    ChangeLog:
    v2:
    Modified to take care of the fact that
    davinci_psc_config() now takes the flags
    directly.

    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

I can check without that flag again, but I do recall it being needed.

Thanks,
Sekhar
