From: rostedt@goodmis.org (Steven Rostedt)
Date: Sat, 07 Aug 2010 08:57:42 -0400
Subject: [PATCH 07/10] ftrace: pass KBUILD_CFLAGS to record_mcount.pl
In-Reply-To: <AANLkTi=Y7WsfrKy2db9j2v8b6PsEhOF2o953R-CvhmhQ@mail.gmail.com>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-8-git-send-email-rabin@rab.in>
	<20100803164247.GA6133@debian>
	<1281126198.3352.6.camel@gandalf.stny.rr.com>
	<AANLkTi=Y7WsfrKy2db9j2v8b6PsEhOF2o953R-CvhmhQ@mail.gmail.com>
Message-ID: <d8f8776d-ddbd-4429-982e-347be439dc02@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for top post. Sent from phone.

Argh! We had this discussion before. I must be getting old.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


"Rabin Vincent" <rabin@rab.in> wrote:

>On Sat, Aug 7, 2010 at 1:53 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>> > ? ? "$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
>>> > ? ? "$(if $(CONFIG_64BIT),64,32)" \
>>> > - ? "$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
>>> > + ? "$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
>>> > + ? "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
>>
>> Hmm, this changes the number of parameters passed to the
>> recordmcount.pl. shouldn't this be part of the change to
>> recordmcount.pl? Otherwise, we can break a bisect.
>
>No, this doesn't change the number of parameters.  KBUILD_CFLAGS
>is included inside the CC argument.
>
>Rabin

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
