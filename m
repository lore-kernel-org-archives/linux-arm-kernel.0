From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 22 May 2014 18:05:53 -0400
Subject: [RFC] ARM: tty: Move HVC DCC assembly to arch/arm
In-Reply-To: <52617F22.6030900@codeaurora.org>
References: <1382120064-2459-1-git-send-email-cov@codeaurora.org>
 <52617F22.6030900@codeaurora.org>
Message-ID: <537E74C1.7020509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 10/18/2013 02:34 PM, Stephen Boyd wrote:
> On 10/18/13 11:14, Christopher Covington wrote:
>> Put architecture-specific assembly code where it belongs,
>> allowing for support of additional architectures such as arm64 in
>> the future.
> 
> Do you have that patch too? There was also a patch a year ago to add
> armv5/v4 support to this driver. Maybe we can resurrect that too.

I still haven't gotten around to testing that one.

>> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
>> index 44fbeba..e9f0191 100644
>> --- a/drivers/tty/hvc/hvc_dcc.c
>> +++ b/drivers/tty/hvc/hvc_dcc.c
>> @@ -8,57 +8,13 @@
>>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>   * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>> - * 02110-1301, USA.
>>   */
>>  
>> -#include <linux/console.h>
>> -#include <linux/delay.h>
>> -#include <linux/err.h>
>> -#include <linux/init.h>
> 
> We still need init.h

Fixed in v2.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
