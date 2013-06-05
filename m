From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Thu, 06 Jun 2013 01:15:15 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <51AFC19F.9040601@wwwdotorg.org>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost> <51AFC19F.9040601@wwwdotorg.org>
Message-ID: <1370474115.20454.26.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ons 2013-06-05 klockan 16:54 -0600 skrev Stephen Warren:

> 1) Put all the parameters in the U-Boot configuration header. This is
> normal.

Yes, we do so today for U-Boot SPL. But this won't fit very well with
the Allwinner ODM workflow where one binary image works on a wide range
of board configurations probed while flashing the image to the board,
but on the other hand there is no real need for them to use u-boot as
the primary boot loader, just keep using boot0 + boot1 + u-boot chain as
they have always done.

> 2) Read some data structure at run-time. This data structure could in
> theory be some SoC-specific blob format (e.g. the packed version of
> information that some tool extracts from FEX/DT), a whole FEX blob, or
> device tree.

This is likely to happen for the sunxi U-Boot SPL due to the sheer
amount of boards involved, and is done to some extents for other boards
as well. In the SPL there generally isn't room for full DT support. Main
u-boot HW configuration could be done runtime via DT alone but we are
not quite there yet, nothing major missing however other than getting it
done.

Regards
Henrik
