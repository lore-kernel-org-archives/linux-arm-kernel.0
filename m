From: bp@alien8.de (Borislav Petkov)
Date: Thu, 13 Aug 2015 10:52:01 +0200
Subject: [PATCH v3 1/4] edac: Add an function to retrieve the EDAC
 debugfs node
In-Reply-To: <20150813104150.2c084a8c@ipc1.ka-ro>
References: <1439326077-25507-1-git-send-email-lho@apm.com>
 <1439326077-25507-2-git-send-email-lho@apm.com>
 <20150812101219.GC14011@nazgul.tnic>
 <20150812104954.GD14011@nazgul.tnic>
 <CAPw-ZT=AFtyLt4CNGBzLZcdPr-ekJpQxKA4Y_AiDzqKfhF1-=w@mail.gmail.com>
 <CAPw-ZTkfAxqG6HQHU3WomrqRwXa+jyTWCg=ns1HKC323ds1yug@mail.gmail.com>
 <20150813081537.GB20004@nazgul.tnic>
 <20150813104150.2c084a8c@ipc1.ka-ro>
Message-ID: <20150813085201.GC20004@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 10:41:50AM +0200, Lothar Wa?mann wrote:
> What's the point in having an accessor function that returns a driver
> internal variable when this variable is exported anyway?

Not driver-internal but EDAC-core internal.

> This will only further inconsistencies because half of the users will
> use the variable directly and the other half will use the accessor
> function.

The idea is that it is not visible outside of EDAC. The EDAC drivers
themselves should see it. And yes, I admit that the accessors are maybe
redundant then since EDAC drivers can use edac_debugfs ptr directly.

Hmm, and that's ok too because my other concern about future refactoring
is taken care of too because as long as all users of edac_debugfs are
confined to drivers/edac/, changing stuff there is easy.

Ok, I'm convinced, Loc, feel free to drop the accessors in your next
version.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
