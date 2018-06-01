From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 1 Jun 2018 18:24:00 +0300
Subject: [PATCH] PCI: move early dump functionality from x86 arch into the
 common code
In-Reply-To: <53e4d6c3-ee19-fd04-4ba3-862d04558689@codeaurora.org>
References: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
 <CAHp75Vc3YKAR1P_F0fwD+ueGub4gVUjP0=wv4Egf_fTSVkSUjw@mail.gmail.com>
 <53e4d6c3-ee19-fd04-4ba3-862d04558689@codeaurora.org>
Message-ID: <CAHp75VdTyvQOqnSm67Uo5heP1otE98BbquM0TjSAorEzTgUwHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 1, 2018 at 6:06 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 6/1/2018 11:02 AM, Andy Shevchenko wrote:
>> On Wed, May 30, 2018 at 7:34 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> Move early dump functionality into common code so that it is available for
>>> all archtiectures. No need to carry arch specific reads around as the read
>>> hooks are already initialized by the time pci_setup_device() is getting
>>> called during scan.
>>
>>>  /* If set, the PCIe ATS capability will not be used. */
>>>  static bool pcie_ats_disabled;
>>>
>>> +bool pci_early_dump;
>>> +
>>
>> I didn't check above these, but maybe a good idea to add one line
>> comment what is this about?
>
> This was discussed here:
>
> https://www.spinics.net/lists/linux-pci/msg72859.html

I understand what is it. What I'm pointing is the variable in the
source without any comment. In the context you have in diff previous
one has a comment.


-- 
With Best Regards,
Andy Shevchenko
