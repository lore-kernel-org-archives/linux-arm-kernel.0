From: B34330@freescale.com (Srivastava Rajan-B34330)
Date: Thu, 1 Aug 2013 06:27:36 +0000
Subject: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to
 architecture independent macro
In-Reply-To: <51F9A5FE.8030608@codeaurora.org>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <1375187900-17582-3-git-send-email-B44344@freescale.com>
 <20130731071630.GI8868@codeaurora.org>
 <CAOZdJXVvNBR-qf7LXNOHZVstH_Rebxwn-wAkSaBS53Wn55mYCw@mail.gmail.com>
 <51F9A5FE.8030608@codeaurora.org>
Message-ID: <0BFD9FDDD35AA74E9F8151ECAEC49CB139CBE1@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner at vger.kernel.org] On Behalf Of Stephen Boyd
Sent: Thursday, August 01, 2013 5:34 AM

>> The answer to your question is that you should not use
>> spin_event_timeout() in interrupt context, because it yields.

> If it yields why are we using udelay? Why not usleep_range()? It would be useful to have a variant that worked in interrupt context and it looked like > that was almost possible.

Looks like the macro yields when 'delay', the third arg to the macro, is zero; otherwise the macro performs one or more udelays. If this is correct, can usleep_range() help?
