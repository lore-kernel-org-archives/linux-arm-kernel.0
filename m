From: austin.lund@gmail.com (Austin Lund)
Date: Fri, 10 Apr 2015 11:59:21 +1000
Subject: gcc to remove -mapcs-frame which will break perf userspace backtraces
 on ARM
Message-ID: <CAHLDD1O0iHYPtL3qi2TmKkaDvPPuUsnGfdFhqWBSxo3TP4peTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using -fomit-frame-pointer with gcc on ARM does not guarantee that the
full frame with the return address is actually pushed onto the stack.
Currently I use -mapcs-frame to achieve this and this allows the code
in perf_callchain.c to generate the right userspace stack traces for
perf.

It seems that gcc have deprecated -mapcs-frame
(https://gcc.gnu.org/ml/gcc-patches/2015-01/msg01001.html)

It isn't clear to me what should replace it.  Any suggestions?
