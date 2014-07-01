From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 1 Jul 2014 16:35:24 +0200
Subject: [PATCH 15/16] ARM: mvebu: Add CPU idle support for Armada 38x
In-Reply-To: <1403875377-940-16-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-16-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140701163524.086a5f79@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 27 Jun 2014 15:22:56 +0200, Gregory CLEMENT wrote:

> +ENTRY(armada_38x_cpu_resume)
> +	/* do we need it for Armada 38x*/
> +ARM_BE8(setend	be )			@ go BE8 if entered LE

We logically needed this, but I've confirmed, and indeed it is really
needed for cpuidle to work properly on Armada 38x in big-endian
configuration.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
