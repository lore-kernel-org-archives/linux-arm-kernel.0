From: chripell@fsfe.org (christian pellegrin)
Date: Mon, 8 Mar 2010 12:17:17 +0100
Subject: [PATCH] Fix GPIOs bank H and J not being preserved during suspend
In-Reply-To: <20100304232115.GB31126@trinity.fluff.org>
References: <cabda6421003022258j51258c56w99b0e75d2d2b088c@mail.gmail.com>
	<1267599637-9283-1-git-send-email-chripell@fsfe.org>
	<20100304232115.GB31126@trinity.fluff.org>
Message-ID: <cabda6421003080317t37124990v72ac56906719c091@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 5, 2010 at 12:21 AM, Ben Dooks <ben-linux@fluff.org> wrote:

>> +#ifdef CONFIG_CPU_S3C244X
>> + ? ? if (pin > S3C2410_GPJ(15))
>> + ? ? ? ? ? ? return NULL;
>> +#else
>
> Hmm, could we use the arch define for number of GPIOs here instead
> of an ifdef?
>


ack, good idea. I'm sending the new patchi in response to this. Tested
on s3c2440 custom board.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
