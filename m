From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jun 2013 00:19:34 +0100
Subject: [PATCH v2 06/11] ARM:stixxxx: Add STiH415 SOC support
In-Reply-To: <51B5BCB3.3060405@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856381-6644-1-git-send-email-srinivas.kandagatla@st.com>
 <CAHTX3d+dk3W_9b7SVUokWq4KYXnj=Z1=WPj5zJ-gUvJqqwE=+Q@mail.gmail.com>
 <51B5BCB3.3060405@st.com>
Message-ID: <20130610231934.GG18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 12:46:59PM +0100, Srinivas KANDAGATLA wrote:
> >     +       aux_ctrl = (0x1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
> >     +               (0x1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
> >     +               (0x1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
> >     +               (way_size << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
> > 
> > 
> > 
> > #include <linux/bitops.h>
> > Linus Walleij would write use  BIT() here
> 
> I will use BIT() macro.

Without checking those fields... BIT() is only appropriate if you're
really talking about single bits.  If you have a field of more than a
single bit which you happen to be setting to '1' then it's not
appropriate to use BIT().
