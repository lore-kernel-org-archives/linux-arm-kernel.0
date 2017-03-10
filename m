From: brian.starkey@arm.com (Brian Starkey)
Date: Fri, 10 Mar 2017 10:31:13 +0000
Subject: [RFC PATCH 00/12] Ion cleanup in preparation for moving out of
 staging
In-Reply-To: <26bc57ae-d88f-4ea0-d666-2c1a02bf866f@redhat.com>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <20170303132949.GC31582@dhcp22.suse.cz>
 <cf383b9b-3cbc-0092-a071-f120874c053c@redhat.com>
 <20170306074258.GA27953@dhcp22.suse.cz>
 <20170306104041.zghsicrnadoap7lp@phenom.ffwll.local>
 <20170306105805.jsq44kfxhsvazkm6@sirena.org.uk>
 <20170306160437.sf7bksorlnw7u372@phenom.ffwll.local>
 <CA+M3ks77Am3Fx-ZNmgeM5tCqdM7SzV7rby4Es-p2F2aOhUco9g@mail.gmail.com>
 <26bc57ae-d88f-4ea0-d666-2c1a02bf866f@redhat.com>
Message-ID: <20170310103112.GA15945@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 09, 2017 at 09:38:49AM -0800, Laura Abbott wrote:
>On 03/09/2017 02:00 AM, Benjamin Gaignard wrote:

[snip]

>>
>> For me those patches are going in the right direction.
>>
>> I still have few questions:
>> - since alignment management has been remove from ion-core, should it
>> be also removed from ioctl structure ?
>
>Yes, I think I'm going to go with the suggestion to fixup the ABI
>so we don't need the compat layer and as part of that I'm also
>dropping the align argument.
>

Is the only motivation for removing the alignment parameter that
no-one got around to using it for something useful yet?
The original comment was true - different devices do have different
alignment requirements.

Better alignment can help SMMUs use larger blocks when mapping,
reducing TLB pressure and the chance of a page table walk causing
display underruns.

-Brian
