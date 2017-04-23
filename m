From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Sun, 23 Apr 2017 12:44:11 +0200
Subject: s3c24xx: Use devm_kcalloc() in s3c24xx_dma_probe()
In-Reply-To: <02134825-fec7-73d7-2eb6-b510eaaf3b08@users.sourceforge.net>
References: <930f0a6c-bc5c-3d01-6814-563780fc90ef@users.sourceforge.net>
 <9c10b823-f49b-8c73-2bf8-0fd2b0ba0231@users.sourceforge.net>
 <f1257887-ca14-6415-b1ff-d57190a1810f@math.uni-bielefeld.de>
 <02134825-fec7-73d7-2eb6-b510eaaf3b08@users.sourceforge.net>
Message-ID: <49f1c0b2-7463-2121-1aed-0998f6635c92@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SF Markus Elfring wrote:
>>> * A multiplication for the size determination of a memory allocation
>>>   indicated that an array data structure should be processed.
>>>   Thus use the corresponding function "devm_kcalloc".
>> I have trouble parsing that sentences. This looks like the typical
>> approach of native german speakers to directly transfer sentence
>> constructions from German to English. Which, in most cases, doesn't work
>> or is just plain confusing.
> 
> Do you find the following wording better to understand
> if it would be presented by a script like ?checkpatch.pl??
> 
> WARNING: Prefer devm_kcalloc over devm_kzalloc with multiply
For example. Also I just noticed some previous comment by Krzysztof that
pointed that out already.

My suggestion: One sentence describing that the current situation is.
Another sentence explaining why this is bad/undesirable. Last sentence
saying what you're doing to fix this (can sometimes be omitted if it's
clear from the diffstat). In this case, the output of the checkpatch
script would come in handy.

With this, you avoid cramming every information into one long and
complicated sentence.

With best wishes,
Tobias


> 
> 
> Regards,
> Markus
> 
