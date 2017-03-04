From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 4 Mar 2017 18:27:08 +0000
Subject: Panic in quirk_usb_early_handoff
In-Reply-To: <ed4e332d-28d6-e143-b2b3-f1e2829e89a7@free.fr>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
 <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
 <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
 <4f0a6c67-a50b-ac24-8ffa-0a68802e84b8@free.fr>
 <CAKv+Gu_M6aMMfeCy7ZUM46Ptei1suvX+F_KtWG2_QFp_6jbCWw@mail.gmail.com>
 <4a07dbec-dcde-9ec0-514f-3b896e2b0b19@free.fr>
 <46A35088-88E2-425B-963E-0DC2DCC54890@linaro.org>
 <ed4e332d-28d6-e143-b2b3-f1e2829e89a7@free.fr>
Message-ID: <239B6CA3-8879-4824-A2AA-A8E8880E1758@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 4 Mar 2017, at 17:29, Mason <slash.tmp@free.fr> wrote:
> 
>> On 04/03/2017 18:16, Ard Biesheuvel wrote:
>> 
>> After pc, the link register is the most likely to legally point into
>> the kernel .text section so it makes sense imo to decode the address
>> into a function name plus offset.
> 
> Does gcc ever use the link register as a general purpose register?

Yes.

> (In which case, it is very likely to contain "garbage" as far as
> function addresses are concerned.)
> 
>> Educating people about the architecture's calling convention and
>> associated caveats is not the job of the panic handler.
> 
> That's a weird statement.
> 

By your own admission (in various threads and in #armlinux on IRC), you are not an expert in the topics you seek help about. Yet, that does not seem to stop you from sharing your opinions vocally, how 'weird' or 'useless' some things are.

As for the lr, I attempted to explain that in some cases, annotating its value can be useful. Adding an explanation to or letting the panic handler reason about whether this is currently the case is not so useful imo.
