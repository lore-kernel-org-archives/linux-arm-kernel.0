From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jun 2014 12:48:06 +0100
Subject: [PATCH] mmc: implement driver stage register handling
In-Reply-To: <CAPDyKFotJr1UkKFs8vqaeh+=VqZvbxY6KmzDQ0HQKFkkr=07ug@mail.gmail.com>
References: <1400852087-32442-1-git-send-email-s.hauer@pengutronix.de>
 <CAPDyKFotJr1UkKFs8vqaeh+=VqZvbxY6KmzDQ0HQKFkkr=07ug@mail.gmail.com>
Message-ID: <20140616114806.GA23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 01:36:38PM +0200, Ulf Hansson wrote:
> On 23 May 2014 15:34, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > @@ -970,6 +971,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >                         goto free_card;
> >         }
> >
> > +       if (card->csd.dsr_imp && (host->dsr & 0xffff) == host->dsr)
> 
> To clarify, maybe add an extra pair of parentheses around the above expression?

To which I say, don't you bloody dare.  It's perfectly readable as it
is, it doesn't need any additional parenthesis.

Additional useless parenthesis detracts from readability.  Don't encourage
stuch stuff.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
