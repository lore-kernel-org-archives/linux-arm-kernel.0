From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 29 May 2014 11:51:00 -0500
Subject: [PATCH v2 03/18] PCI: designware: Configuration space should be
 specified in 'reg'
In-Reply-To: <20140529163037.GC2552@obsidianresearch.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
 <1401345500-20188-4-git-send-email-kishon@ti.com>
 <98E18225-3C63-4106-901A-A5D3DEC268C8@codeaurora.org>
 <20140529151840.GD1677@bart.dudau.co.uk>
 <CF1BAF3F-E16E-4864-8052-8C3EC29000B0@codeaurora.org>
 <20140529163037.GC2552@obsidianresearch.com>
Message-ID: <A9B853EE-65C6-4B2E-ABC0-1E64DE584E91@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 29, 2014, at 11:30 AM, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:

> On Thu, May 29, 2014 at 11:03:36AM -0500, Kumar Gala wrote:
> 
>> Just because the kernel doesn?t handle this is NO reason to change
>> the way the DT works.
> 
> The OF specs do not specify how to process a config type ranges entry,
> and we all mutually agreed that the only sane interpretation for such
> a thing would be to describe an ECAM memory space so generic code
> could potentially make use of it.
> 
> Since designware is not ECAM it should not use config ranges.
> 
> This has come up multiple times now, and the above is the consensus.
> 
> Jason

Well the designware controller does support ECAM, just that the current in kernel users don?t do cfg space that way.

So do we continue to support the current users that use a cfg range for a non-ECAM space?  Or break their DT and convert them to using regs?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
