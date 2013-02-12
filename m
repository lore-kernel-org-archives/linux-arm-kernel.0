From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Feb 2013 17:08:44 -0700
Subject: [PATCH V3 1/2] get_maintainer: allow keywords to match filenames
In-Reply-To: <1360627226.4707.6.camel@joe-AO722>
References: <1360626016-23332-1-git-send-email-swarren@wwwdotorg.org>
 <1360627226.4707.6.camel@joe-AO722>
Message-ID: <5119880C.8010602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 05:00 PM, Joe Perches wrote:
> On Mon, 2013-02-11 at 16:40 -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Allow K: entries in MAINTAINERS to match directly against filenames;
>> either those extracted from patch +++ or --- lines, or those specified
>> on the command-line using the -f option.
> []
>> I don't think setting exact_pattern_match_hash would be appropriate here;
>> at least for intended Tegra use case, this feature is to ensure that all
>> Tegra-related driver changes get Cc'd to the Tegra mailing list. Setting
>> exact_pattern_match_hash would prevent git history parsing for e.g. S-o-b
>> tags, which still seems like it would be useful. Hence, this flag isn't
>> set.
> 
> And I don't think that's necessary because for filenames,
> you could add the appropriate control to the MAINTAINERS
> 
> "K:	^pattern$"

Does "that" above mean "not setting exact_pattern_match_hash", or
"changing the patch so that it does set exact_pattern_match_hash". Sorry...
