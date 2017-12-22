From: Jan.Tuerk@emtrion.de (=?iso-8859-1?Q?T=FCrk=2C_Jan?=)
Date: Fri, 22 Dec 2017 12:44:26 +0100
Subject: AW: [PATCH v2 4/5] ARM: dts: Add support for emtrion emCON-MX6 series
In-Reply-To: <20171222105642.GD18255@piout.net>
References: <95F51F4B902CAC40AF459205F6322F01B7FDFECC3C@BMK019S01.emtrion.local>
 <20171222104028.GC18255@piout.net>
 <b41bc779-28e8-5a87-6f66-f5874dba8d1e@suse.de>
 <20171222105642.GD18255@piout.net>
Message-ID: <95F51F4B902CAC40AF459205F6322F01B7FDFECC3F@BMK019S01.emtrion.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi,

> On 22/12/2017 at 11:43:33 +0100, Andreas F?rber wrote:
> > >> I'll change it for v3 of this patch however it will end up like this:
> > >> //SPDX-License...
> > >
> > > That should be /* SPDX-License */, // is for c files.
> >
> > Got any reference for that? Since we're using the C preprocessor
> > before feeding them to dtc, we can use the same // style for both, builds fine.
> >
> > Only for my private DT overlay files that I use directly with dtc I
> > couldn't adopt that style.
> >
> The doc states:
> 
> If a specific tool cannot handle the standard comment style, then the
> appropriate comment mechanism which the tool accepts shall be used. This is
> the reason for having the "/\* \*/" style comment in C header files.
> 
> I interpreted that as dtc doesn't handle // comments, use /**/
> 
> But I agree it also states:
> .dts{i}:	  // SPDX-License-Identifier: <SPDX License Expression>
> 
> So I think we will end up with a mix of both.
> 
after some regexp on arch/arm/boot/dts, the current state is:
216 SPDX identifiers total
	184 by GregKH in b24413180f5600bcb3bb70fbed5cf186b60864bd starting with //
	2 times /*  also by GregKH in the commit above (in .h files)
	27 occurrences of  "* SPDX"

However, the de-facto comment style in the arm devicetrees seems to be /* */
So with the current information I would prepare v3 with:

// SPDX-License-Identifier
/* Copyright-text + Header
*/
[...]

Jan

---
emtrion GmbH
Alter Schlachthof 45
76131 Karlsruhe
GERMANY
https://www.emtrion.de

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
-------------- next part --------------
A non-text attachment was scrubbed...
Name: winmail.dat
Type: application/ms-tnef
Size: 5618 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171222/45969992/attachment-0001.bin>
