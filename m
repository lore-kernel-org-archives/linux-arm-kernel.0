From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Oct 2013 20:41:35 +0200
Subject: [PATCH v2 0/3] ARM: NEON based fast(er) AES in CBC/CTR/XTS modes
In-Reply-To: <alpine.LFD.2.03.1310041420520.3023@syhkavp.arg>
References: <1380837566-18242-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131004174853.GY24303@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1310041420520.3023@syhkavp.arg>
Message-ID: <CAKv+Gu9Lnn4=ENMc1Q+9Bkwj1R+2yk91KK1iETaes_OWaTO+fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 October 2013 20:34, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 4 Oct 2013, Will Deacon wrote:
[...]
>>
>> Why do you consider it unsuitable to ship the perl script with the kernel?
>> Perl 5 is already documented as a build dependency in Documentation/Changes
>
> Do you have an example of something that does require perl to build the
> kernel on ARM?  I was under the impression that people try to avoid it
> as much as possible in general.
>
> I'm personally sitting on the fence between effectively adding a new
> kernel build dependencies or carrying the output of the perl script.
> But if the kernel build does already require perl in practice then this
> might tip the balance.
>

I like Russell's suggestion the most, in fact. In this case, the build
time requirement for Perl effectively gets suspended until you start
making modifications to the perl script, and the relation between the
.S and the .pl files is made explicit by the make rule.

Should I put the cmd_perl rule in scripts/Makefile.build ? Or can I
just keep it under arch/arm/crypto ?

-- 
Ard.
