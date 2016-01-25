From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 25 Jan 2016 17:38:07 +0200
Subject: [PATCH v6] kernel: add kcov code coverage
In-Reply-To: <CACT4Y+a_Tvi643CUVey=1_i4R+vV=_ZSrsP92AMRjcEo1V-dKw@mail.gmail.com>
References: <1453726850-49137-1-git-send-email-dvyukov@google.com>
 <CACT4Y+a_Tvi643CUVey=1_i4R+vV=_ZSrsP92AMRjcEo1V-dKw@mail.gmail.com>
Message-ID: <20160125153806.GA12391@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 02:03:55PM +0100, Dmitry Vyukov wrote:
> On Mon, Jan 25, 2016 at 2:00 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > kcov provides code coverage collection for coverage-guided fuzzing
> > (randomized testing). Coverage-guided fuzzing is a testing technique
> > that uses coverage feedback to determine new interesting inputs to a
> > system. A notable user-space example is AFL
> > (http://lcamtuf.coredump.cx/afl/). However, this technique is not
> > widely used for kernel testing due to missing compiler and kernel
> > support.
> 
> Kirill, I export kcov file as 0600 now.
> 
> Any more comments?

Acked-by: Kirill A. Shutemov <kirill@shutemov.name>

I have some doubts if debugfs knob is the right way to go. Maybe it would
be better to integrate the feature with perf somehow as it has tracing
capabilities.

But that's just a side note. I don't have a strong opinion about the
interface.

+CC perf people.

-- 
 Kirill A. Shutemov
