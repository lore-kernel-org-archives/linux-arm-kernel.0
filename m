From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 2 Mar 2016 10:23:49 +0000
Subject: [PATCH v2 1/2] efi: esrt: use memremap not ioremap to access
 ESRT table in memory
In-Reply-To: <20160302011619.GA3192@dhcp-128-65.nay.redhat.com>
References: <CAKv+Gu_AW7PKJJOd2mbEu3LKJe+gNaPHnH=sgO=YXM_KWFyKxw@mail.gmail.com>
 <20160218132824.GE2651@codeblueprint.co.uk>
 <CAKv+Gu-s1pzYBzuDG-Z7s3gyo8dPOfeidZQ+rim-uAWZCBcKQQ@mail.gmail.com>
 <20160218134324.GG2651@codeblueprint.co.uk>
 <CAKv+Gu875r9RkDC723kNsG4XC0eSE9RPPmSFZrD0sx0QxS+V4g@mail.gmail.com>
 <20160218141544.GH2651@codeblueprint.co.uk>
 <20160218191624.GA1515@redhat.com>
 <20160226144114.GA7475@codeblueprint.co.uk>
 <20160301233040.GA31476@codeblueprint.co.uk>
 <20160302011619.GA3192@dhcp-128-65.nay.redhat.com>
Message-ID: <20160302102349.GA2649@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 02 Mar, at 09:16:19AM, Dave Young wrote:
> 
> Matt, thanks. One question is for the acpi patches you sent before, do you
> think they are still necessary as a fix for the bgrt problem and coexist
> with the "reserve useful boot services" proposal?

No, the previous ACPI patches I sent can be thrown in the bin if we go
with the approach outlined in this email.

This approach is superior because it allows useful features such as
ESRT and the new memory attributes to be used for kexec boot - the
ACPI patches prevented a crash by disabling BGRT.
