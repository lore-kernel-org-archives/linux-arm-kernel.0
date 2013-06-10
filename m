From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Mon, 10 Jun 2013 23:43:19 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <CAHp75Vdqc9xiPBvQUB3Hfb4EBFUsoVxyuH8MK=9spJ4+rieoDQ@mail.gmail.com>
References: <1370185130-15332-1-git-send-email-oliver+list@schinagl.nl>
 <1370185130-15332-2-git-send-email-oliver+list@schinagl.nl>
 <CAHp75Vdqc9xiPBvQUB3Hfb4EBFUsoVxyuH8MK=9spJ4+rieoDQ@mail.gmail.com>
Message-ID: <51B64877.4040908@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/13 21:16, Andy Shevchenko wrote:

Thank you andy for your review, I do have a few questions/comments if 
you don't mind.
> On Sun, Jun 2, 2013 at 5:58 PM, Oliver Schinagl <oliver+list@schinagl.nl> wrote:
>> From: Oliver Schinagl <oliver@schinagl.nl>
<snip>
>> +       if (likely((SID_SIZE))) {
>
> Extra braces.
> Use antipattern here.

While I accidentally dropped the pointer here, sorry for the confusion, 
what is antipattern? I have asked around and nobody really knew.

Wikipedia mentions it as a software development thing, but you make it 
sound like it is some sort of tool?

<snip>
>> +       if (unlikely(!pdev->dev.of_node)) {
>> +               dev_err(dev, "No devicetree data available\n");
>> +               ret = -EFAULT;
>> +               goto exit;
>
> Plain return here and in entire function where it applies.
Why? I know there's conflicting preferences here. The general consensus 
seems, don't return mid function if you don't absolutely have to. Yet, 
you make it sound, just return wherever. I take it that really is just a 
preference? I think i see both constructs throughout the kernel. So one 
review prefers the one method, the next the other?
<snip>
>> +
>> +       ret = device_create_bin_file(dev, &sid_bin_attr);
>> +       if (unlikely(ret)) {
>
> Any benifit of (un)likely in probe()?
Does it hurt however in any way though? It's just a compiler 
optimization isn't it.

<snip>
>
> --
> With Best Regards,
> Andy Shevchenko
>
Thank you for your time, it is much appreciated :)

Oliver
