From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 18 Apr 2013 16:29:54 +0100
Subject: [PATCH v7 2/3] of/pci: Provide support for parsing PCI DT ranges
 property
In-Reply-To: <20130418142434.GA18881@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-3-git-send-email-Andrew.Murray@arm.com>
 <20130418134401.84AEE3E1319@localhost>
 <20130418142434.GA18881@arm.com>
Message-ID: <CACxGe6u7yoecyTR2r-EzpcRxLuSw-p9KC7jA12wEQZs4of3vFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 3:24 PM, Andrew Murray <andrew.murray@arm.com> wrote:
> On Thu, Apr 18, 2013 at 02:44:01PM +0100, Grant Likely wrote:
>> On Tue, 16 Apr 2013 11:18:27 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:
>> >             /* Act based on address space type */
>> >             res = NULL;
>> > -           switch ((pci_space >> 24) & 0x3) {
>> > -           case 1:         /* PCI IO space */
>> > +           res_type = range.flags & IORESOURCE_TYPE_BITS;
>> > +           if (res_type == IORESOURCE_IO) {
>>
>> Why the change from switch() to an if/else if sequence?
>
> Russell King suggested this change - see
> https://patchwork.kernel.org/patch/2323941/

Umm, that isn't what that link shows. That link shows the patch
already changing to an if/else if construct, and rmk is commenting on
that.

g.
