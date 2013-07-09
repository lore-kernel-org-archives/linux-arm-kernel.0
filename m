From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 9 Jul 2013 10:30:42 -0600
Subject: [PATCHv4 05/11] of: pci: add registry of MSI chips
In-Reply-To: <20130709160132.7f5e7a8e@skate>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_Jsq+h=y5SNo4qO5-5u_w8rW++9MKDZK8rASNjhtVcjh-iyQ@mail.gmail.com>
 <20130709160132.7f5e7a8e@skate>
Message-ID: <CAErSpo6cnHbE3RSu8HFn09SY66tOZZG95JEvKFmzHieXYV0NYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 9, 2013 at 8:01 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> On Tue, 9 Jul 2013 08:43:36 -0500, Rob Herring wrote:
>> > +{
>> > +       struct msi_chip *c;
>> > +       list_for_each_entry(c, &msi_chip_list, list) {
>>
>> Need the safe variant here?
>
> As suggested by Bjorn, I've changed this function to grab the
> msi_chip_mutex while traversing the list.

The "safe" list functions don't do any mutual exclusion.  The only
safety they provide is that we won't go in the weeds if the body of
the loop deletes the current list entry.  This loop doesn't delete
entries, so we don't need the safe variant.

Bjorn
