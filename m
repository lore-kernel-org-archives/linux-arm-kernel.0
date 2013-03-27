From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 27 Mar 2013 12:15:44 +0200
Subject: [RFC 00/14] Add DT support to OMAPDSS
In-Reply-To: <5152BC4A.1060804@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
 <5152BC4A.1060804@ti.com>
Message-ID: <5152C6D0.2010708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-03-27 11:30, Benoit Cousson wrote:
> Hi Tomi,
> 
> On 03/27/2013 09:45 AM, Tomi Valkeinen wrote:
>> Hi,
>>
>> This is an RFC for OMAPDSS DT support. I've only added support for a few boards
>> and a few DSS outputs, but they should give quite a good range of different use
>> cases. If these work well, I think the rest of the outputs and panels will be
>> ok too.
>>
>> The purpose of this series is to get comments about the dts changes. There are
>> still work to be done, like adding DT binding documentation.
>>
>> Some notes:
>>
>> * DSS Submodules
>>
>> The DSS submodules are children of the dss_core node. This is done because the
>> submodules require the dss_core to be alive and initialized to work, even if
>> the submodules are not really behind dss_core. Having the submodules as
>> children will make runtime PM automatically handle the dependency to dss_core.
>> I think usually a node being a child means that it's on the parent's bus, which
>> is not the case here. I'm not sure if that's an issue or not.
> 
> FWIW, there is a L4_DSS interconnect. It is used internally to connect
> all the submodules to the DSS L3 port. So this representation is
> perfectly valid and does represent accurately the HW.

Ah, yes, I can see it mentioned in the OMAP4430 Block Diagram figure in
the TRM. No other mentions, though, I guess it's not really relevant =).
But good to know that the DT representation is actually correct.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/0b25e833/attachment.sig>
