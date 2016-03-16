From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 13:27:36 -0500
Subject: [PATCH 3/5] ARM: davinci: da8xx: add cfgchip2 to resources
In-Reply-To: <56E9A456.2000204@cogentembedded.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
 <1458081473-8223-3-git-send-email-david@lechnology.com>
 <56E8906E.7070800@cogentembedded.com> <56E8D720.7000508@lechnology.com>
 <56E8E7C7.70901@lechnology.com> <56E99A16.9020709@cogentembedded.com>
 <56E9A282.7030103@lechnology.com> <56E9A456.2000204@cogentembedded.com>
Message-ID: <56E9A598.40308@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2016 01:22 PM, Sergei Shtylyov wrote:
>
>     The set_mode() method doesn't have anything to do with the
> predefined roles. What CFGCHIP2 setting do is to override the ID input
> (and also the VBUS level comparator). This is not required for the
> normal functioning of either host or peripheral AFAIR.
>

OK, so it sounds like I should just remove set_mode from the musb driver 
completely and make this configurable in the phy driver via platform 
data or device tree.
