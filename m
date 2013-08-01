From: B44344@freescale.com (Goel Arpit-B44344)
Date: Thu, 1 Aug 2013 04:38:34 +0000
Subject: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to
 architecture independent macro
In-Reply-To: <CAOZdJXW8uF_e2nQr3gAiMf4E5pvsH_S-ztAXvx9R7-nXyaZGag@mail.gmail.com>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <1375187900-17582-3-git-send-email-B44344@freescale.com>
 <CAOZdJXW8uF_e2nQr3gAiMf4E5pvsH_S-ztAXvx9R7-nXyaZGag@mail.gmail.com>
Message-ID: <0DFB48290CDB0C4680160EBE62E8F9A809E9A2E0@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 7:38 AM, Arpit Goel <B44344@freescale.com> wrote:
>
> +#ifndef spin_event_timeout
> +/**

On Thursday, August 01, 2013 5:32 AM Timur Tabi [mailto:timur at tabi.org] wrote:
> Why don't you make PowerPC also use this generic version?  It seems silly to have two virtually identical implementations of this macro?

PowerPC uses hardware timer registers provided by PowerPC architecture to implement spin_event_timeout(). These registers make
PowerPC implementation of spin_event_timeout() more granular in comparison to ones using generic USECS_PER_JIFFY framework. This
would handle those cases more granularly in which evaluation of "condition" is taking time or fails.    
