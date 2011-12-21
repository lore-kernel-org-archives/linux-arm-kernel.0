From: arjan@linux.intel.com (Arjan van de Ven)
Date: Wed, 21 Dec 2011 20:36:12 +0100
Subject: [PATCH 0/3] coupled cpuidle state support
In-Reply-To: <CAMbhsRRnKoR3YPWrZzVynVe+dcuU5v0siYvmp2vbBcS1hquC7Q@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <4EF1A0B4.5080307@linux.intel.com>
 <CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw@mail.gmail.com>
 <4EF1AA8A.8060304@linux.intel.com>
 <CAMbhsRSNTUvou9Gf6T4Ggq=jfxsWUcn7M2yNsKQz6aNrt6gLDg@mail.gmail.com>
 <4EF1CD49.9020800@linux.intel.com>
 <CAMbhsRRnKoR3YPWrZzVynVe+dcuU5v0siYvmp2vbBcS1hquC7Q@mail.gmail.com>
Message-ID: <4EF2352C.3060102@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> .. or it enters WFI, and a physical device sends it an interrupt,
>> at which point it exits.
> 
> None of the cpus will return to the idle loop until all cpus have
> decremented the ready counter back to 0, so they can't wrap around
> again.


yikes, so you IPI all the cpus on the first exit.
that must burn power ;-(
