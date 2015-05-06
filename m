From: bp@alien8.de (Borislav Petkov)
Date: Wed, 6 May 2015 20:29:00 +0200
Subject: [PATCH v8 0/4] edac: Add APM X-Gene SoC memory controller EDAC
 driver
In-Reply-To: <CAPw-ZTkuZWNM9D_wJRfQq009KeL1coyYKXhqhWV+FWW6C=xRiA@mail.gmail.com>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
 <2150970.xGYLhDU9BR@wuerfel>
 <CAPw-ZTkuZWNM9D_wJRfQq009KeL1coyYKXhqhWV+FWW6C=xRiA@mail.gmail.com>
Message-ID: <20150506182900.GI22949@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 11:12:20AM -0700, Loc Ho wrote:
> 1. Whether to have an single driver for APM EDAC or multiple instance
> of 4 different drivers. With single driver, it does not scale in the
> future when we add/remove memory controllers and CPU domains. This is

Why doesn't it scale? Please explain this to me more verbosely.

> also agreed by Rob Herring from review of the DTS nodes. For L3 and
> SoC EDAC, they are less of an issue as I don't see a situation that we
> would have multiple instances.
> 
> 2. With regard to the top level PCP interrupt, they are just for
> status and once configured, it will not be touch. Therefore, I keep
> the current implementation. With an single driver, there is no need to
> worry about read/modify/write as it will be guarded with an lock. For
> multiple instance, I am thinking that the xgene_edac_mc module will
> provide exported lock functions for the other drivers.

Doing this would be a very bad design and it would be a homegrown case
only for this driver. Then other ARM drivers will appear which will do
their own locking too. No no no. No ad-hoc hackery.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
