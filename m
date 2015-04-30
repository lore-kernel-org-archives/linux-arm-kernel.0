From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 30 Apr 2015 16:31:07 +0200
Subject: [PATCH v4 04/10] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <552FEA74.5020909@free-electrons.com>
References: <1429118648-19416-1-git-send-email-antoine.tenart@free-electrons.com>
 <1429118648-19416-5-git-send-email-antoine.tenart@free-electrons.com>
 <552EB7F0.2090106@gmail.com> <552FB4DF.1030403@free-electrons.com>
 <552FBC0E.20004@gmail.com> <552FEA74.5020909@free-electrons.com>
Message-ID: <20150430143106.GE4433@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 01:59:32PM -0300, Ezequiel Garcia wrote:
> On 04/16/2015 10:41 AM, Sebastian Hesselbarth wrote:
> 
> > All we need is a function to convert sdr_timings to sane driver
> > timings. And we really need to split this patch into tiny pieces
> > otherwise it is not reviewable - or at least I need a full overview
> > about the driver first.
> > 
> 
> I think that's a bit of a different issue. This patch seems to be doing
> two things: it removes the in-driver flash detection *and* reworks
> timing setup.
> 
> How about we split this in two or even three patches? Along these lines:
> 1) introduce timing helpers, 2) rework timing setup, 3) remove in-driver
> flash detection. Not sure how feasible it is.

That's quite difficult, as you cannot have 1) without having the changes
made in 2). Flash detection and timing reworks are linked and I'm not
sure we can have this split into 2 or 3 patches without having a state
where the driver does not work.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
