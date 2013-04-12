From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 12 Apr 2013 22:11:59 +0400
Subject: [PATCH v3 0/9] Reorganize R8A7779/Marzen USB code
In-Reply-To: <20130412003457.GC24461@verge.net.au>
References: <201304100226.08967.sergei.shtylyov@cogentembedded.com>
 <20130410044923.GD10044@verge.net.au> <20130410085033.GL7983@arwen.pp.htv.fi>
 <20130410090543.GB25890@verge.net.au> <20130411005155.GA18530@verge.net.au>
 <5166A659.6060405@cogentembedded.com> <20130412003457.GC24461@verge.net.au>
Message-ID: <51684E6F.5030009@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/12/2013 04:34 AM, Simon Horman wrote:

>>>>>>>     Here's the set of 9 patches against the Simon Horman's 'renesas.git' repo,
>>>>>>> 'renesas-next-20130410' tag.  It was created to fix the shortcomings in the
>>>>>>> R8A7779/Marzen USB platform code and R8A7779 USB common PHY driver, and so
>>>>>>> spans both arch/arm/mach-shmobile/ and drivers/usb/ subtrees (some patches have
>>>>>>> to touch both subtrees). The patches were conceived with the complete
>>>>>>> bisectability goal in mind.
>>>>>>> [1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
>>>>>>> [2/9] ehci-platform: add pre_setup() method to platform data
>>>>>>> [3/9] ARM: shmobile: R8A7779: setup EHCI internal buffer
>>>>>>> [4/9] rcar-phy: remove EHCI internal buffer setup
>>>>>>> [5/9] ARM: shmobile: R8A7779: remove USB PHY 2nd memory resource
>>>>>>> [6/9] rcar-phy: correct base address
>>>>>>> [7/9] rcar-phy: add platform data
>>>>>>> [8/9] ARM: shmobile: Marzen: pass platform data to USB PHY device
>>>>>>> [9/9] rcar-phy: handle platform data
>>>>>>>     I'm not sure thru which tree this patchset should be merged, however it turns
>>>>>>> out that it's too late now to push it thru Felipe Balbi's USB tree for 3.10
>>>>>>> (which would have been most convenient probably), and it's probably too late to
>>>>>>> merge thru Simon's tree for 3.10 too. So it now have to be postponed to 3.11,
>>>>>>> unfortunately...
>>>>>> Felipe, how would you prefer to handle this?
>>>>>> I'm happy for you to take it or to take it myself.
>>>>> please take it yourself, just keep in mind there will be conflicts, I
>>>>> will go over the patches now and give my Acked-by so you can queue them
>>>>> up.
>>>> Thanks
>>> Sergei, it looks like patches 1-7 are clear.
>>     #7 & #9 have been refused by Felipe (hence #8 isn't good too).
>>
>>> Do you want me to start queueing them up.
>>     I was going to repost the whole series soon, adding ACK from Alan

    It's not as soon as I had hoped but I hope I would be able to do it
in several hours...

>> to the patch #2 and resolving issues with patches #7..#9. It's worth
>> waiting for that to happen I think.
> I am quite happy to wait.
>
> One minor comment - there is no need to repost just to fix this -
> could you consider using lower-case for the socs for consistency
> with the common practice in patch subject lines.
>
> e.g.: ARM: shmobile: r8a7779: setup EHCI

     Alright, although I have a kind of idiosyncrasy to lowercasing 
otherwise
uppercase names.

>
>>> Or would you rather wait for the issue with patch 6 to be resolved?
>>     There's no special issue with patch #6 other than the PHY driver
>> files being renamed in Felipe's tree -- but that concerns all
>> patches touching drivers/usb/phy/rcar-phy.c (some of which precede
>> #6).
> Sorry, I made an error. I meant #8 and in turn #9.

    The issues start at patch #7 actually, where the platform data
represenation seemed inappropriate to Felipe.

>
>>     I don't know how the rename conflict will be handled (this is
>> really bad coincidence), perhaps I still should have done this
>> patchset against Felipe's 'next' branch and pushed it thru his tree.
>> If the patches will be queued for 3.11 anyway, maybe it's worth
>> doing that -- I'm still of the opinion that his tree would be the
>> one most fitting for this patchset.
> It seems that git will handle it :)

     Well, let's hope. There's still an issue with header file name it
wouldn't be able to handle but I'll probably leave it as is, as the other
PHY files in include/linux/usb/ didn't get renamed in the big rename.

WBR, Sergei
