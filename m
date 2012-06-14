From: matt@grid-net.com (Matt Burtch)
Date: Thu, 14 Jun 2012 16:49:18 +0000
Subject: MXS getting AUART to work with DT.
In-Reply-To: <CAOMZO5Bc2ag4WLV+YwqpR7OOfMatd9CBBdT8koFabkPVcQacFw@mail.gmail.com>
References: <4FD7EFFC.8010204@grid-net.com>
 <CAOMZO5BDFD3hHt+HW_sdh-3hCEwgJJA9C0ecAJZSOUCw_725Jw@mail.gmail.com>
 <4FD96B3E.6080806@grid-net.com>,
 <CAOMZO5Bc2ag4WLV+YwqpR7OOfMatd9CBBdT8koFabkPVcQacFw@mail.gmail.com>
Message-ID: <2CC96C7FBBE82548A0B1766B8D8348AD9C169E@mx2.grid-net.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the patch I put together to get the AUART recognized with the dt.  I'm pretty new to dt development, so this was a quick first pass. I'm sure there are more proper ways to get the device id and pass literals between the dt and probe function...but this works for now.

Regards,
-Matt Burtch
________________________________________
From: Fabio Estevam [festevam at gmail.com]
Sent: Wednesday, June 13, 2012 9:54 PM
To: Subodh Nijsure
Cc: linux-arm-kernel at lists.infradead.org; Marek Va?ut; Shawn Guo; Matt Burtch
Subject: Re: MXS getting AUART to work with DT.

On Thu, Jun 14, 2012 at 1:40 AM, Subodh Nijsure <snijsure@grid-net.com> wrote:

> With this change you will only see AUART0 being created all subsequent
> attempts fail.  I think we need to have dt specific probe, my colleague Matt
> Burtch has implemented that dt specific probe for AUART will request him to
> send his diff tomorrow AM.
>
> I think something is broken in 3.5 as far as I can tell AUART goes it had
> worked for me in 3.4, I am novice at device-tree and was not sure if its
> because of DT or something else.

Ok, just tested linux-next and I see that mxs-auart probes correctly
for the non-dt kernel.

We need to fix mxs-auart for dt now.

Regards,

Fabio Estevam
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mxs-auart.patch
Type: text/x-patch
Size: 3155 bytes
Desc: mxs-auart.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/9fae73f8/attachment-0001.bin>
