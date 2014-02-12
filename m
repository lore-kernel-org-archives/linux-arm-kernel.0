From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Feb 2014 15:35:37 -0700
Subject: [PATCH 1/2] ARM: tegra: enable I2C Mux driver for PCA9546 in
 defconfig
In-Reply-To: <CAK5ve-+2AGO0UCf4UOMLoqGmQLp7QN08OJbZxUc-oYZzjPdFcQ@mail.gmail.com>
References: <1391817298-10600-1-git-send-email-pengw@nvidia.com>
 <52FBC6A9.7010401@wwwdotorg.org>
 <CAK5ve-+bzLkdwmab9sZGPk7p67ktVcK3mHQ2aUgMueH061ty6w@mail.gmail.com>
 <52FBD6C9.2010905@wwwdotorg.org>
 <CAK5ve-+2AGO0UCf4UOMLoqGmQLp7QN08OJbZxUc-oYZzjPdFcQ@mail.gmail.com>
Message-ID: <52FBF739.1060605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2014 02:55 PM, Bryan Wu wrote:
> On Wed, Feb 12, 2014 at 12:17 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 02/12/2014 01:09 PM, Bryan Wu wrote:
>>> On Wed, Feb 12, 2014 at 11:08 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> On 02/07/2014 04:54 PM, Bryan Wu wrote:
>>>>> PCA9546 is used in Cardhu Tegra30 board to connect to 3 cameras.
>>>>> Enabling this driver for Tegra V4L2 soc camera driver and camera
>>>>> sensor drivers.
...
>>>> Note that your patches were sent with an email "From" address that
>>>> didn't match your signed-off-by tag, yet "git send-email" didn't insert
>>>> a "From" header in the email body. Can you please check your git user ID
>>>> and/or email settings. Consequently, I had to adjust the git author
>>>> field in git to match your s-o-b line.
...
>> Why not just put the correct values in ~/.gitconfig?
>>
>> Perhaps this is because you switch between NVIDIA and non-NVIDIA email
>> addresses and/or mail servers, so you can't make ~/.gitconfig static and
>> universally correct? If you have a recent enough git, what I do is:
...
> Awesome, I will firstly update my .gitconfig. Actually I basically
> just have one outbound server which is gmail server. Although I put
> From: @nvidia.com, I still use gmail server to send out patch emails.
> Still don't wanna touch our internal email server.

You shouldn't send email with a from address @nvidia.com from a server
other than NVIDIA's servers. If you do, plenty of people will drop the
email as SPAM, since NVIDIA publishes SPF[1] records (and perhaps other
email configuration) for nvidia.com. Since there are good reasons not to
use NVIDIA's email servers, that means: tell git the actual email
address you're sending from (for the email settings; you should set the
author/commit ID to your @nvidia.com address still).

[1] http://www.openspf.org/

$ dig -t spf nvidia.com
...
nvidia.com.		180	IN	SPF	\
	"v=spf1 mx/24 mx:nvidia.com/24 -all"
