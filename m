From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 8 Aug 2017 13:15:55 +0000
Subject: [v6 11/15] arm64/kasan: explicitly zero kasan shadow memory
In-Reply-To: <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
 <20170808090743.GA12887@arm.com>
 <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD004DA79@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pasha Tatashin
> Sent: 08 August 2017 12:49
> Thank you for looking at this change. What you described was in my
> previous iterations of this project.
> 
> See for example here: https://lkml.org/lkml/2017/5/5/369
> 
> I was asked to remove that flag, and only zero memory in place when
> needed. Overall the current approach is better everywhere else in the
> kernel, but it adds a little extra code to kasan initialization.

Perhaps you could #define the function prototype(s?) so that the flags
are not passed unless it is a kasan build?

	David
