From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 12 Jan 2014 20:03:50 +0100
Subject: [PATCH RFC 01/10] ARM: s3c64xx: pm: Use name field of
 generic_pm_domain
In-Reply-To: <20140112185337.GA6810@amd.pavel.ucw.cz>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
 <20140112114717.GA31318@amd.pavel.ucw.cz> <52D287B1.3090106@gmail.com>
 <20140112185337.GA6810@amd.pavel.ucw.cz>
Message-ID: <52D2E716.8040403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.01.2014 19:53, Pavel Machek wrote:
> Hi!
>
>>> Could we get some more descriptive names for the domains?
>>
>> They are listed like this in user's manual, e.g. DOMAIN_F, DOMAIN_I,
>> DOMAIN_G, etc.
>
> I guessed so. So the manual sucks. Would it be feasible to get it more
> descriptive (like "Domain_G (GPU)")?

Does the name really matter that much? I changed original ones in this 
patch simply to make it easier to grep for domain related messages in 
kernel output (e.g. dmesg | grep domain). It was not the main part of 
this patch.

Also, there are multiple devices in most domains, so that would rather 
end up being "Domain_I (JPEG, Cam I/F)", "Domain_P (2D, TV Enc., 
Scaler)", "Domain_F (Rot, Post, LCD)".

If you really insist, I can change this, but I fail to see what effect 
it would really have.

Best regards,
Tomasz
