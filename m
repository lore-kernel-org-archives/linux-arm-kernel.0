From: robherring2@gmail.com (Rob Herring)
Date: Tue, 09 Jul 2013 17:52:14 -0500
Subject: [PATCHv4 05/11] of: pci: add registry of MSI chips
In-Reply-To: <20130709160132.7f5e7a8e@skate>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_Jsq+h=y5SNo4qO5-5u_w8rW++9MKDZK8rASNjhtVcjh-iyQ@mail.gmail.com>
 <20130709160132.7f5e7a8e@skate>
Message-ID: <51DC941E.60007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 09:01 AM, Thomas Petazzoni wrote:
> Rob,
> 
> On Tue, 9 Jul 2013 08:43:36 -0500, Rob Herring wrote:
> 
>>> +int of_msi_chip_add(struct msi_chip *chip)
>>
>> Perhaps of_pci_msi_chip_add instead.
> 
> Sure, makes sense.
> 
>>> +{
>>> +       struct msi_chip *c;
>>> +       list_for_each_entry(c, &msi_chip_list, list) {
>>
>> Need the safe variant here?
> 
> As suggested by Bjorn, I've changed this function to grab the
> msi_chip_mutex while traversing the list.
> 
> Does your e-mail implies that the general approach seems ok? If so,
> I'll resend an updated v5 version taking into account the comments
> that I have received on this v4.

Yes. Since it is only trivial comments, you can add my ack.

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> 
> Thanks!
> 
> Thomas
> 
