From: bp@alien8.de (Borislav Petkov)
Date: Thu, 13 Aug 2015 10:15:37 +0200
Subject: [PATCH v3 1/4] edac: Add an function to retrieve the EDAC
 debugfs node
In-Reply-To: <CAPw-ZTkfAxqG6HQHU3WomrqRwXa+jyTWCg=ns1HKC323ds1yug@mail.gmail.com>
References: <1439326077-25507-1-git-send-email-lho@apm.com>
 <1439326077-25507-2-git-send-email-lho@apm.com>
 <20150812101219.GC14011@nazgul.tnic>
 <20150812104954.GD14011@nazgul.tnic>
 <CAPw-ZT=AFtyLt4CNGBzLZcdPr-ekJpQxKA4Y_AiDzqKfhF1-=w@mail.gmail.com>
 <CAPw-ZTkfAxqG6HQHU3WomrqRwXa+jyTWCg=ns1HKC323ds1yug@mail.gmail.com>
Message-ID: <20150813081537.GB20004@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 09:30:58PM -0700, Loc Ho wrote:
> Okay... The 'inline' helps with the compiler warning. If I move all to
> header file with 'static inline' and wrapper around CONFIG_EDAC_DEBUG,
> don't I need to export and declare the variable 'edac_debugfs'? Are
> you okay with export this variable?

You need to make edac_debugfs extern in the header and define it in
edac_mc_sysfs.c.

But that's ok because edac_core.h will be included only by EDAC drivers
and they're supposed to see edac_debugfs anyway...

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
