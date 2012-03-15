From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 14 Mar 2012 19:42:31 -0500
Subject: [PATCH v4 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <20120314204935.GB12334@avionic-0098.mockup.avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-3-git-send-email-thierry.reding@avionic-design.de>
 <ADE657CA350FB648AAC2C43247A983F0020695DB57DC@AUSP01VMBX24.collaborationhost.net>
 <20120314204935.GB12334@avionic-0098.mockup.avionic-design.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020695DB587C@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 14, 2012 1:50 PM, Thierry Reding wrote:
> * H Hartley Sweeten wrote:
>> On Wednesday, March 14, 2012 8:56 AM, Thierry Reding wrote:
> [...]
>>> +#ifdef CONFIG_DEBUG_FS
>>> +	void			(*dbg_show)(struct pwm_chip *chip,
>>> +					    struct seq_file *s);
>>> +#endif
>> 
>> This doesn't compile...
>> 
>> include/linux/pwm.h:87: warning: 'struct seq_file' declared inside parameter list
>> include/linux/pwm.h:87: warning: its scope is only this definition or declaration, which is probably not what you want
>
> Okay, pwm.h probably needs a seq_file.h include. Thanks for noticing.

Or just a:

struct seq_file;

Regards,
Hartley
