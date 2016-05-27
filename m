From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 27 May 2016 10:42:29 +0200
Subject: [PATCH] pinctrl: samsung: Suppress unbinding to prevent
 theoretical attacks
In-Reply-To: <CACRpkdYdo5XsJvb9GTYph7P=u31treiDX6HZGbG_AGzW5hp1HQ@mail.gmail.com>
References: <1463464926-17482-1-git-send-email-k.kozlowski@samsung.com>
 <CACRpkdYdo5XsJvb9GTYph7P=u31treiDX6HZGbG_AGzW5hp1HQ@mail.gmail.com>
Message-ID: <57480875.2040502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2016 11:08 AM, Linus Walleij wrote:
> On Tue, May 17, 2016 at 8:02 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> 
>> Although unbinding a pinctrl driver requires root privileges but it
>> still might be used theoretically in certain attacks (by triggering NULL
>> pointer exception or memory corruption).
> 
> Patch applied with Javier's review tag.
> 
> I suspect this kind of patch should be done to a few
> GPIO controller :/

Probably yes... Either the driver properly and safely handles unbind
(remove() callback) or it should be forbidden. In the same time, even if
remove() is implemented, unbinding some of the core SoC drivers is like
shooting self in the foot.

Best regards,
Krzysztof
