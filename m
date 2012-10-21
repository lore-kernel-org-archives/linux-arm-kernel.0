From: oleg@redhat.com (Oleg Nesterov)
Date: Sun, 21 Oct 2012 21:40:58 +0200
Subject: [PATCH 3/9] uprobes: allow ignoring of probe hits
In-Reply-To: <20121021181504.GA4840@ubuntu>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-3-git-send-email-rabin@rab.in>
 <20121015165218.GA10239@redhat.com>
 <CAH+eYFBHXAWTinnVO8vEnEhFDQLibwo+BtxYJJYdPcG9__n5OQ@mail.gmail.com>
 <20121017173510.GA11019@redhat.com> <20121021181504.GA4840@ubuntu>
Message-ID: <20121021194058.GA29137@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21, Rabin Vincent wrote:
>
> On Wed, Oct 17, 2012 at 07:35:10PM +0200, Oleg Nesterov wrote:
> >
> > And, to clarify, I am not arguing. Just curious.
> >
> > So, is this like cmov on x86? And this patch allows to not report if
> > the condition is not true? Or there are other issues on arm?
>
> Yes, I guess this is like CMOV on x86.  In the ARM instruction set most
> instructions can be conditionally executed.
>
> In order to set the probe on a conditional instruction, we use an
> undefined instruction with the same condition as the instruction we
> replace.  However, it is implementation defined whether an undefined
> instruction with a failing condition code will trigger an undefined
> instruction exception or just be executed as a NOP.  So for those
> processor implementations where we do get the undefined instruction
> exception even for a failing condition code, we have to ignore it in
> order to provide consistent behaviour.

OK, I see, thanks for your explanation.

Oleg.
