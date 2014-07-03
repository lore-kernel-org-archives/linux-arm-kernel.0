From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 3 Jul 2014 14:55:14 +0200
Subject: [PATCH 09/16] ARM: mvebu: Make the snoop disable optional in
 mvebu_v7_pmsu_idle_prepare
In-Reply-To: <53B5518E.3050702@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-10-git-send-email-gregory.clement@free-electrons.com>
 <20140630174338.13604523@free-electrons.com>
 <53B5518E.3050702@free-electrons.com>
Message-ID: <20140703145514.65addd5a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 03 Jul 2014 14:50:22 +0200, Gregory CLEMENT wrote:

> Maybe we can use flags, hence we use only one arguments, it became extensible,
> and more readable too. Something like
> 
> #define PMSU_IDLE_NO_FLAG 0
> #define PMSU_IDLE_DEEPIDLE BIT(0)
> #define PMSU_IDLE_SNOOPDIS BIT(1)
> 
> then we can have:
> mvebu_v7_pmsu_idle_prepare(PMSU_IDLE_SNOOPDIS);
> mvebu_v7_pmsu_idle_prepare(PMSU_IDLE_DEEPIDLE | PMSU_IDLE_SNOOPDIS);
> mvebu_v7_pmsu_idle_prepare(PMSU_IDLE_NO_FLAG);
> 
> static void mvebu_v7_pmsu_idle_prepare(u32 flags)

Yes, seems a good idea to me. Used "unsigned int" as the type for the
flags argument, and maybe use PMSU_IDLE_NORMAL for 0 instead of NO_FLAG.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
