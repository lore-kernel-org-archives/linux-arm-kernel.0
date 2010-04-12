From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 12 Apr 2010 23:04:40 +0100
Subject: [RFC PATCH v5 0/2] ARM: VFP: Save / restore VFP state on the
	signal handler path
In-Reply-To: <cover.1270199787.git.imre.deak@nokia.com>
References: <1270070606-5732-1-git-send-email-imre.deak@nokia.com>
	<cover.1270199787.git.imre.deak@nokia.com>
Message-ID: <20100412220440.GF6148@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imre.deak at nokia.com wrote:
> From: Imre Deak <imre.deak@nokia.com>
> 
> Changes since v4:
> - Do not add the packed attribute to user_vfp or user_vfp_exc.
>   I added packed to these structs to prevent the extra padding in
>   vfp_sigframe. But actually the padding is in accordance with the
>   ARM ABI.

EABI, OABI or both?

In general it's a really good idea, if you know there will be padding,
to insert dummy fields where the padding goes so that it doesn't make
any difference what compiler, ABI and settings are used.

-- Jamie
