From: rabin@rab.in (Rabin Vincent)
Date: Sat, 7 Aug 2010 11:03:06 +0530
Subject: [PATCH 07/10] ftrace: pass KBUILD_CFLAGS to record_mcount.pl
In-Reply-To: <1281126198.3352.6.camel@gandalf.stny.rr.com>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-8-git-send-email-rabin@rab.in>
	<20100803164247.GA6133@debian>
	<1281126198.3352.6.camel@gandalf.stny.rr.com>
Message-ID: <AANLkTi=Y7WsfrKy2db9j2v8b6PsEhOF2o953R-CvhmhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 7, 2010 at 1:53 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > ? ? "$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
>> > ? ? "$(if $(CONFIG_64BIT),64,32)" \
>> > - ? "$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
>> > + ? "$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
>> > + ? "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
>
> Hmm, this changes the number of parameters passed to the
> recordmcount.pl. shouldn't this be part of the change to
> recordmcount.pl? Otherwise, we can break a bisect.

No, this doesn't change the number of parameters.  KBUILD_CFLAGS
is included inside the CC argument.

Rabin
