From: robherring2@gmail.com (Rob Herring)
Date: Sun, 25 Mar 2012 20:59:22 -0500
Subject: [PATCH 1/2] ARM: VIC: Create common infrastructure for vic DT
 bindings
In-Reply-To: <CAOh2x=n-sZ6jV1M9XY9cOp7_8EeRfvqkjL5y3AakgpYymFRHkg@mail.gmail.com>
References: <4bfe7af3761f6f40506a2089fd67866015f6d7f3.1332488625.git.viresh.kumar@st.com>
 <4F6C6F32.10800@gmail.com>
 <CAOh2x=n-sZ6jV1M9XY9cOp7_8EeRfvqkjL5y3AakgpYymFRHkg@mail.gmail.com>
Message-ID: <4F6FCD7A.3030804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2012 02:31 AM, viresh kumar wrote:
> On Fri, Mar 23, 2012 at 6:10 PM, Rob Herring <robherring2@gmail.com> wrote:
>> NAK
>>
>> None of these platforms have gpio interrupts or any other board
>> interrupt controllers which need to be initialized early?
> 
> Atleast SPEAr600 have GPIO interrupts.
> 
>> I don't think DT conversions are complete enough to tell.
> 
> Couldn't get your comment, sorry.

Some DT enabled platforms may only have the gic or vic included in their
match list currently because other interrupt controllers aren't yet
converted to DT. I believe Exynos is one such example.

> 
>> We could do something like this, but there only needs to be a single
>> match list of all controllers and function. We should consolidate the
>> irqchips to drivers/irqchip first though. I have that action from Connect...
> 
> That would be good.
> I am updating DT support for SPEAr3xx, where i need to use VIC OF
> support. So i would still like to get this patch going and you can consilidate
> code at irqchips level later. What do you say?

No. I don't think moving this into the gic and vic code just to move it
back out later is a good idea. Just looking at the diffstat, the net
number of lines removed is not very compelling either.

Rob

> 
> --
> viresh
