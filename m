From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Mon, 14 Sep 2009 20:34:35 +0530
Subject: EXT_CSD  Register : CSD_STRUCTURE vs CSD_CSD_REV
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am working in Linux MMC driver.
Recently I came across one 16GB MMC card where EXT_CSD Register having EXT_CSD_REV[192] field as ZERO, which is valid according to Specification. But card is not working due to following reason -

 1.  As we know there are two fields in Extended CSD Register -  CSD_STRUCTURE Version[194] & EXT_CSD_REV Revision [192].


 1.  In mmc.c/ mmc_read_ext_csd ()
    *   Implementation expecting EXT_CSD_REV non zero (e.g. >3 in current code)
    *   I think it could be checking for CSD_STRUCTURE version.
    *   Because EXT_CSD_REV having Zero is the valid Field.
    *   This is the way it's done in other OS too.


 1.  To check the high capacity card.
    *   We could check in access mode from OCR.  This is not in Linux exactly and steps to check the EXT_CSD_REV.
    *   This is done in some other OS too.

So do you think we can update the code to check the CSD_STRUCTURE Version? Please let us know your opinion.

[cid:image001.gif at 01CA357A.C599E580]
[cid:image002.gif at 01CA357A.C599E580]

Thanks & regards,
Sukumar Ghorai

-------------------------------------------------------------------------------------

WTSD, Texas Instruments,

#66/3 Bagmane Tech Park, CVRaman Nagar, Bangalore, India-560093.

Voice: +91-80-25048868

http://www.india.ti.com<http://www.india.ti.com/>

-------------------------------------------------------------------------------------

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090914/27668f3e/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.gif
Type: image/gif
Size: 15335 bytes
Desc: image001.gif
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090914/27668f3e/attachment-0002.gif>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image002.gif
Type: image/gif
Size: 10512 bytes
Desc: image002.gif
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090914/27668f3e/attachment-0003.gif>
