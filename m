From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 22 Sep 2014 09:25:13 -0600
Subject: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
In-Reply-To: <20140922110522.GK1994@e106497-lin.cambridge.arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
 <20140919210313.GH19374@google.com>
 <20140922110522.GK1994@e106497-lin.cambridge.arm.com>
Message-ID: <CAErSpo7bnOFo4-uZmVsMqNpVQS+dQaMNedjmJ=sH_d9Kp2fGPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 5:05 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Fri, Sep 19, 2014 at 10:03:13PM +0100, Bjorn Helgaas wrote:
>> On Thu, Sep 18, 2014 at 02:30:22AM +0100, Liviu Dudau wrote:
>> > Add of_pci_get_domain_nr() to retrieve the PCI domain number
>> > of a given device from DT. If the information is not present,
>> > the function can be requested to allocate a new domain number.
>>
>> Is of_pci_get_domain_nr() used somewhere?  If the use is in some future
>> series, please mention it explicitly.  I'm just trying to avoid merging
>> unused code.
>
> It is used in the arm64 specific patch that I have dropped out of my
> pull request. After discussions with Catalin I will add the patch back
> into the tree that you've pulled from as he is OK with your tree carrying
> the whole package.
>
> I need to ask for some guidance here: for addressing some of your comments
> and Rob's I can add more patches in my v11 branch and you can pull them
> when you think they are ready. But one of your comments was requesting
> splitting a patch into two blocks - one that moves of_pci_range_to_resource()
> into drivers/of/address.c and one that fixes it's behaviour - and I don't
> know how you would like that handled. Should I revert the original patch
> and add the new ones, or should I rebase the whole series into a different
> branch that you can pull from?

I guess the easiest thing is probably just to send a v12 series.  I
was hoping we were close enough for me to just hand-integrate minor
tweaks into my branch, but I think that will just create more
confusion.

Bjorn
