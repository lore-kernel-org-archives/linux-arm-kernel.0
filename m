From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 30 Jul 2012 15:42:13 -0700
Subject: [PATCH v3 1/3] ARM: omap: clk: add clk_prepare and clk_unprepare
In-Reply-To: <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com>
References: <1341224669-15231-1-git-send-email-rnayak@ti.com>
 <1341224669-15231-2-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com>
Message-ID: <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 3:31 PM, Paul Walmsley <paul@pwsan.com> wrote:
> So if we make a change like this one, it seems like we would basically
> expect it to break once we start doing anything meaningful with
> clk_prepare(), like using clk_prepare() for voltage scaling or something
> that requires I2C?  We'd also probably want to mark this with some kind of
> "HACK" comment.

Hi Paul,

Did you have anything in mind to start using clk_prepare?  I still
hope to get rid of it some day and replace that call with a
combination of clk_enable and a check like clk_enable_can_sleep.

Regards,
Mike
