From: tony@atomide.com (Tony Lindgren)
Date: Wed, 1 Jun 2011 09:46:06 +0300
Subject: [PATCH] ARM: omap4: Pass core and wakeup mux tables to
	omap4_mux_init
In-Reply-To: <BANLkTikfXs1oLott64+C5wy59G24Mux0TJ52et7GTEMQrfqRFQ@mail.gmail.com>
References: <1304546278-28965-1-git-send-email-ccross@android.com>
	<20110531124208.GF11352@atomide.com>
	<BANLkTikfXs1oLott64+C5wy59G24Mux0TJ52et7GTEMQrfqRFQ@mail.gmail.com>
Message-ID: <20110601064606.GC8696@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Colin Cross <ccross@android.com> [110531 21:46]:
> On Tue, May 31, 2011 at 5:42 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Colin Cross <ccross@android.com> [110504 14:54]:
> >> OMAP4 contains two separate instances of the padconf registers,
> >> one in the core system config and one in the wakeup system config.
> >> Pass in two tables to apply the correct values to each instance.
> >
> > Hmm good catch thanks. Will queue this as a fix.
> 
> This patch doesn't work without another fix to allow NULL to be passed
> to omap4_mux_init.  Do you prefer allowing NULL, or adding empty
> board_wkup_mux arrays to every board file?  I have a patch for the
> first option.

OK, saw that patch and adding to fixes. Passing NULL here is fine.

Tony
