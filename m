From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Feb 2012 22:16:51 -0800
Subject: [PATCH v4 2/4] irq: add irq_domain support to generic-chip
In-Reply-To: <CACxGe6u9KjMF0vLWebL0y-J4GqbqzP4HPx6w49pPOjJ51aqooQ@mail.gmail.com>
References: <1328308512-22594-1-git-send-email-robherring2@gmail.com>
 <1328308512-22594-3-git-send-email-robherring2@gmail.com>
 <CACxGe6u9KjMF0vLWebL0y-J4GqbqzP4HPx6w49pPOjJ51aqooQ@mail.gmail.com>
Message-ID: <20120208061649.GA28996@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 04:47:17PM -0700, Grant Likely wrote:
> On Fri, Feb 3, 2012 at 3:35 PM, Rob Herring <robherring2@gmail.com> wrote:
...
> > +static struct irq_domain_ops irq_gc_irq_domain_ops = {
> > + ? ? ? .map = irq_gc_irq_domain_map,
> > + ? ? ? .xlate = irq_domain_xlate_onetwocell,
> 
> Can we hard-enforce _xlate_twocell here?  Are there any users using
> just one cell?  Alternately, can we make the caller specify if one or
> two cells are expected?
> 
I did not notice this comment until I tried Rob's v5 branch.  The imx5
TZIC uses just one cell.

-- 
Regards,
Shawn
