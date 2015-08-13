From: lho@apm.com (Loc Ho)
Date: Wed, 12 Aug 2015 21:30:58 -0700
Subject: [PATCH v3 1/4] edac: Add an function to retrieve the EDAC debugfs
 node
In-Reply-To: <CAPw-ZT=AFtyLt4CNGBzLZcdPr-ekJpQxKA4Y_AiDzqKfhF1-=w@mail.gmail.com>
References: <1439326077-25507-1-git-send-email-lho@apm.com>
 <1439326077-25507-2-git-send-email-lho@apm.com>
 <20150812101219.GC14011@nazgul.tnic>
 <20150812104954.GD14011@nazgul.tnic>
 <CAPw-ZT=AFtyLt4CNGBzLZcdPr-ekJpQxKA4Y_AiDzqKfhF1-=w@mail.gmail.com>
Message-ID: <CAPw-ZTkfAxqG6HQHU3WomrqRwXa+jyTWCg=ns1HKC323ds1yug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>
>>> EXPORT_SYMBOL_GPL() if it is going to be used by modules.
>>
>> Better yet, move it to the header.
>
> I can't move it completely to the header and make it static. It will
> generate a lot of compiler warning as it isn't used by other modules.
> I will add EXPORT_SYMBOL_GPL() in the next version.

Okay... The 'inline' helps with the compiler warning. If I move all to
header file with 'static inline' and wrapper around CONFIG_EDAC_DEBUG,
don't I need to export and declare the variable 'edac_debugfs'? Are
you okay with export this variable? Or, it is static inline if not
defined CONFIG_EDAC_DEBUG. Otherwise, just  an extern header function
and export it as well?

-Loc
