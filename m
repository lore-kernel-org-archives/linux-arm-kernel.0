From: bob.dunlop@xyzzy.org.uk (Bob Dunlop)
Date: Tue, 7 Jun 2011 08:41:45 +0100
Subject: [PATCH 2/3] davinci: dm6467/T EVM: pass reference clock rate
	to dm646x_init()
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D383514@dbde02.ent.ti.com>
References: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
	<1307034677-27236-2-git-send-email-nsekhar@ti.com>
	<4DEB7DD4.5050706@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D38344A@dbde02.ent.ti.com>
	<20110606122552.GA2729@xyzzy.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024D383514@dbde02.ent.ti.com>
Message-ID: <20110607074145.GA6593@xyzzy.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06 at 06:32, Nori, Sekhar wrote:
...
> > Add the ref_clk_rate parameter to the davinci_soc_info structure and
> > perform the clock adjustment in davinci_common_init().  The code assumes
> 
> Lets not extend davinci_soc_info any further. We need to be looking
> at ways of reducing its usage (for example by making GPIO code use
> platform device).
> 
> Also, refclk is a board information not soc information so placing
> it there makes it misplaced.

Okay let's drop this idea.  I must admit I was concerned about opening
up the structure availability.

-- 
        Bob Dunlop
